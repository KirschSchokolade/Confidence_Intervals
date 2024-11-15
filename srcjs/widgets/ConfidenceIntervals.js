import 'widgets';
import Chart from 'chart.js/auto'
import { getRelativePosition } from 'chart.js/helpers';

import drag from 'chartjs-plugin-dragdata'
import zoomPlugin from 'chartjs-plugin-zoom';


HTMLWidgets.widget({

  name: 'ConfidenceIntervals',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    Chart.register(drag, zoomPlugin)

        return {

      renderValue: function(x) {

    var counter = 0;
    var last_main_value = 0
    let canvas = $(el)
    let label_len = x.labels.length;
    var old_value = 0;

    let data = {
      labels: x.labels,
      datasets: [
        {
          label: 'Book Sales',
          type: "line",
          data: x.chart_data,
          fill: false,
          borderColor: x.color_main,
          tension: 0,
          yAxisID: 'y'
      },
          {
              label: "BandTop",
              type: "line",
              borderColor: x.color_top,
              fill: +1,
              tension: 0,
              data: x.top_band,
              yAxisID: 'y',
              xAxisID: 'x'
          },
          {
              label: "BandBottom",
              type: "line",
              backgroundColor: x.background_color,
              borderColor: x.color_bottom,
              fill: +1,
              tension: 0,
              data: x.bottom_band,
              yAxisID: 'y',
              xAxisID: 'x',
          }

      ]
  };

    const start_length = data.datasets[0].data.length;


        // TODO: code to render the widget, e.g.
      const chart =   new Chart(canvas,{
    type: 'line',
    data: data,
    options: {
        maintainAspectRatio: false,
        responsive: true,
        onHover: function (e) {
            const point = e.chart.getElementsAtEventForMode(e, 'nearest', {intersect: true}, false)
            if (point.length) e.native.target.style.cursor = 'grab'
            else e.native.target.style.cursor = 'default'
        },
        onClick: (e) => {
            const canvasPosition = getRelativePosition(e,this);
            let clicked_value = chart.scales.y.getValueForPixel(canvasPosition.y)
            insert_points(clicked_value, x.insertion_type);
            return_data_points_to_server(x.insertion_type)

            chart.update()
        },
        plugins: {
            legend : {
              display: x.show_legend

            },
            tooltip: {
              enabled: x.show_tooltip
            },
            dragData: {
                round: 1,
                showTooltip: true,
                onDragStart: (e, datasetIndex, index, value) => {
                    //
                    if (index <= start_length)
                    {
                      old_value = value;
                      return ;
                    }
                },
                onDragEnd: function (e, datasetIndex, index, value) {
                     if (index <= start_length)
                    {
                      data.datasets[datasetIndex].data[index] = old_value;
                      chart.update()
                      return ;
                    }
                    e.target.style.cursor = 'default';
                    return_data_points_to_server(x.insertion_type)
                }
            },
            zoom: {
                pan:{
                    enabled: true,
                    modifierKey: 'meta',
                    threshold: 10,
                    mode: 'y',
                },
                zoom: {
                    wheel: {
                        enabled: true,
                    },
                    pinch: {
                        enabled: true
                    },
                    mode: 'xy',
                }
            }
        },
        scales: {
            y: {
                // The axis for this scale is determined from the first letter of the id as `'x'`
                // It is recommended to specify `position` and / or `axis` explicitly.
                min:x.axis_limits[0],
                max: x.axis_limits[1],
                type: 'linear'
            }
        }
    }
})

function insert_points(clicked_value, insertion_type){
  // Function inserts the last clicked point into the data structures.
  // Different modes have different behaviors on how to insert data and which data to insert.
  switch (insertion_type) {
    case 'OnlyIntervals':
      if(counter % 2 === 0 ){
        data.datasets[1].data.push(clicked_value);
        last_main_value = clicked_value
        counter++;
      }
      else {
        if (clicked_value > last_main_value){
                    clicked_value = last_main_value + (last_main_value - clicked_value)
                }
        data.datasets[2].data.push(clicked_value);
        counter++;
      }

      break;
    case 'PointForecastFirst':
       if(counter === 0){
              data.datasets[0].data.push(clicked_value);
              counter++;
              last_main_value = clicked_value
            }
            else if (counter === 1){
                if (clicked_value < last_main_value){

                    clicked_value = last_main_value + (last_main_value - clicked_value)
                }
                data.datasets[1].data.push(clicked_value);
                counter++;
            }
            else{
                if (clicked_value > last_main_value){
                    clicked_value = last_main_value - (clicked_value - last_main_value)
                }
                data.datasets[2].data.push(clicked_value);
                counter = 0;
            }
      break;
    case 'IntervalFirst':
      if(counter === 0){
              data.datasets[1].data.push(clicked_value);
              counter++;
              last_main_value = clicked_value
            }
            else if (counter === 1){
                if (clicked_value > last_main_value){
                    clicked_value = last_main_value + (last_main_value - clicked_value)
                }
                data.datasets[2].data.push(clicked_value);
                counter++;
            }
            else{
                if (clicked_value > last_main_value){
                    clicked_value = last_main_value - (clicked_value - last_main_value)
                }
                data.datasets[0].data.push(clicked_value);
                counter = 0;
            }
      break;

  }

}

function return_data_points_to_server(insertion_type){
    // Returns the data points to the server. Each insertion type needs to build its
    // own return object.

    switch(insertion_type){
      case 'OnlyIntervals':
        if (data.datasets[2].data.length === label_len){
          let ret = {
            "upper_band" : data.datasets[1].data,
            "lower_band" : data.datasets[2].data
          }
          console.log(ret)
          Shiny.setInputValue("foo", ret)
      }
        break;
        case 'PointForecastFirst':
          if (data.datasets[2].data.length === label_len){
            let ret = {
              "main_line" :  data.datasets[0].data,
              "upper_band" : data.datasets[1].data,
              "lower_band" : data.datasets[2].data
            }
            console.log(ret)
            Shiny.setInputValue("foo", ret)
          }
          break;
        case 'IntervalFirst':
           if (data.datasets[0].data.length === label_len){
            let ret = {
              "main_line" :  data.datasets[0].data,
              "upper_band" : data.datasets[1].data,
              "lower_band" : data.datasets[2].data
            }
            console.log(ret)
            Shiny.setInputValue("foo", ret)
           }
          break;
    }
}
// Render function stops here.
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },
      getChart: function(){
        return Chart.getChart(canvas.id);
      }

    };
  }
});

function get_chartjs(id){
  let widget = HTMLWidgets.find("#" + id);
  let chart = widget.getChart();
  return chart;

};



