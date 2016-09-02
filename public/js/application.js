$(document).ready(function(){
  $("#shortener_form").on("submit", function(event){
    event.preventDefault();
    $.ajax({
      url: "/urls",
      method: "POST",
      dataType: "JSON",
      data: { long_url: $(this).children("input").first().val() },
      success: function(data){
        console.log(data);
        if (data.flash != undefined){
          $("#flash").html(data.flash);
          $("#flash").toggle().delay(2000).toggle("slow");
        }
        if (data.url != undefined){
          console.log(data);
          var listNumber = parseInt($("#link-table tr:last td:first").text()) + 1;
          $("#link-table").append("\
            <tr class='tr-content'>\
              <td>" + listNumber + "</td>\
              <td>" + data.url.long_url + "</td>\
              <td>\
                <a href='http://localhost:9393/" + data.url.short_url + "' target='_blank'>http://localhost:9393/" + data.url.short_url + "\
                </a>\
              </td>\
              <td class='center'>" + data.url.click_count + "</td>\
            </tr>\
          ");
          $("#shortener_form").children("input").first().val("");
        }
      }
    })
  })
})