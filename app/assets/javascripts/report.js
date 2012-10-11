
var calcTotals = function () {
  $.getJSON("report.json", function(json){
    var totals = {};

    $('#periods tr').show()
    $.each(json, function(n) { //filter the json and add values in an array
      if(
        json[n].length && 
        json[n].in >= formatDate('startdate') && 
        json[n].out <= formatDate('enddate') && 
        (json[n].employee.id == $('#event_employee_id :selected').val() || $('#event_employee_id :selected').val() == '' ) && 
        (json[n].job.id == $('#event_job_id :selected').val() || $('#event_job_id :selected').val() == '' )
        ) {
        var employeeId = json[n].employee.id;
        var jobId = json[n].job.id;
        if(!totals[employeeId]) totals[employeeId] = {}  //initialize
        if(!totals[employeeId][jobId]) totals[employeeId][jobId] = 0 //initialize

        totals[employeeId][jobId] += json[n].length
      }
      else {
        $('#periods tr:eq(' + (n+1) + ')').hide() // if it fails the filter, hide the row
      }
    })


    $('#matrix td').html(''); //clear the table

    total =  0;
    totals['job'] = {}
    $.each(totals, function(employee,values) { // add all the subtotals and stuff them in the matrix table
      totals['employee'] = 0
      $.each(totals[employee], function(job,values) {
        var cell = $('#employee' + employee + ' .job' + job)
        cell.html(totals[employee][job].toFixed(2))
        totals['employee'] += totals[employee][job]
        if (totals['job'][job]  && employee != 'job') {
          totals['job'][job] += totals[employee][job]
        }
        else  {
          totals['job'][job] = totals[employee][job]
        }
      });
      $('#employee' + employee + ' .total').html(totals['employee'].toFixed(2))
    });
    $.each(totals['job'], function(job, values) {
      total += totals['job'][job]
      $('.total .job' + job).html(totals['job'][job].toFixed(2))
    });
    $('#periods .totals .length, #matrix .total td:last-child').html((total).toFixed(2)); //store the grand total
  });
}

var truncateLogs = function() {
  $('#periods .pre').each(function(n) {
    if ($(this).height() > 44) {
      $(this).wrapInner('<div class="truncate" />').append('<a href="#" class="moreLink">more...</a>')
    }
  });
  $('.moreLink').click(function (event) {
    event.preventDefault();
    if($(this).hasClass("less")) {
        $(this).removeClass("less");
        $(this).html('more...');
        $(this).siblings().addClass('truncate');
    } else {
        $(this).addClass("less");
        $(this).html('less...');
        $(this).siblings().removeClass('truncate');
    }
  })
}

var formatDate = function (sourceID) {
  return $('#' + sourceID + '_').val() + "-00:00"
}



/////// filters filters filters

