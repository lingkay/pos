(function($) {
    /*************** 1. MAIN FUNCTION ***************/
    $(document).ready(function() {
        init();
        onChanges();
        onClicks();
        onMouseUps();
    });
    /*****---------- 1.1 INIT ----------*****/
    function init() {

        console.log("hello");

    }
    /*****---------- 1.2 onChanges ----------*****/
    function onChanges() {

    }
    /*****---------- 1.3 onClicks ----------*****/
    function onClicks() {
        $('#navbar_main_items').on('show.bs.collapse', function() {
            var id = $(this).attr('id');
            var $toggler = $(document).find('.navbar-toggler[data-target="#' + id + '"]');
            var $hamburger = $toggler.find('.hamburger');
            if ($hamburger.length < 1) {
                return;
            }
            $hamburger.addClass('is-active');
        }).on('hide.bs.collapse', function() {
            var id = $(this).attr('id');
            var $toggler = $(document).find('.navbar-toggler[data-target="#' + id + '"]');
            var $hamburger = $toggler.find('.hamburger');
            if ($hamburger.length < 1) {
                return;
            }
            $hamburger.removeClass('is-active');
        });
    }
    /*****---------- 1.4 OnMouseUp ----------*****/
    function onMouseUps() {

    }

    /*************** 2. FUNCTIONS ***************/
    /*****---------- 2.1 REUSABLE FUNCTIONS ----------*****/
    /**------------- 2.1.1 Random Class Name -------------**/
    window.randomClass = function(length) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        for (var i = 0; i < length; i++) text += possible.charAt(Math.floor(Math.random() * possible.length));
        return text;
    };
    /**------------- 2.1.2 Field accepts number only -------------**/
    window.fieldNumberOnly = function(field_element) {

        $(document).on('keydown', field_element, function(e) {
            if ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105)) {
                if (e.shiftKey) {
                    return false;
                }
                return true;
            } else if (e.keyCode == 173 || e.keyCode == 189 || e.keyCode == 109 || //dashes
                (e.shiftKey && e.keyCode == 61) || e.keyCode == 107 || e.keyCode == 187 //plus signs
            ) {
                return true;
            } else if ((e.keyCode <= 46 && e.keyCode != 32) || (e.keyCode >= 112 && e.keyCode <= 123) ||
                (e.keyCode >= 144 && e.keyCode <= 145)) {
                return true;
            } else if (e.ctrlKey || (e.ctrlKey && e.shiftKey) || (e.shiftKey && e.altKey)) {
                return true;
            } else {
                return false;
            }
        });

    };
    /*****---------- 2.2 ADDITIONAL FUNCTIONS   ----------*****/
})(jQuery.noConflict());