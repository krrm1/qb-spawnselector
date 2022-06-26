window.addEventListener('message', function(event) {
    let data = event.data;

    switch (data.event) {
        case 'show':
            $("body").show();
            break;

        case 'hide':
            $("body").hide();
            break;

        case 'update':
            $(".name").html(data.label);
            break;
    }
});

$(".button").click(function() {
    let el = $(this), type = el.attr("type");
    if (type) {
        $.post(`https://arabcodingteam-spawnselector/${type}`);
    }
});

$(".spawn").click(function() {
    $.post(`https://arabcodingteam-spawnselector/spawn`);
});

$(".lastloc").click(function() {
    $.post(`https://arabcodingteam-spawnselector/lastloc`);
});
