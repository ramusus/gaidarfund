$(function(){
    // Form hints
    $('.b-hint-label').hints();

    // Fixing filter
    var filter = $('#filter');

    if( filter.length ){
        var scrollTop = $(document).scrollTop(),
            filterHeight = filter.height(),
            fixedFilterClass = 'b-fixed-filter',
            bottomFilterClass = 'b-bottom-filter',
            content = $('.l-content'),
            start = filter.offset().top - 20,
            finish = 0;

        fixFilter();

        $(window).scroll(function(){
            scrollTop = $(document).scrollTop();
            fixFilter();
        });
    }

    function fixFilter( immidiately ){
        finish = content.offset().top + content.height() - filterHeight - 20;

        if( scrollTop < start ){
            if( filter.hasClass(fixedFilterClass) ){
                filter.removeClass(fixedFilterClass);
            }
            if( filter.hasClass(bottomFilterClass) ){
                filter.removeClass(bottomFilterClass);
            }
        }
        else if( (scrollTop >= start && scrollTop < finish) || immidiately ){
            if( !filter.hasClass(fixedFilterClass) ){
                filter.addClass(fixedFilterClass);
            }
            if( filter.hasClass(bottomFilterClass) ){
                filter.removeClass(bottomFilterClass);
            }
        }
        else{
            if( filter.hasClass(fixedFilterClass) ){
                filter.removeClass(fixedFilterClass);
            }
            if( !filter.hasClass(bottomFilterClass) ){
                filter.addClass(bottomFilterClass);
            }
        }
    }

    // Articles with more button
    var tiles = $('#tiles'),
        moreTilesLink = $('#more-tiles');

    if( tiles.length && moreTilesLink.length ){
        tiles.masonry({
            itemSelector: '.b-tiles-item'
        });

        moreTilesLink.click(function(event){
            $.ajax({
                url: $(this).attr('href')
            }).done(function(response){
                var newItems = $(response);
                newItems = newItems.filter('.b-tiles-item');

                newItems.css({opacity: 0}).appendTo(tiles);
                newItems.animate({opacity: 1});

                tiles.masonry('appended', newItems, true);

                if( filter.length ){
                    fixFilter(true);
                }
            });
            event.preventDefault();
        });
    }
});


String.prototype.supplant = function (o) {
    return this.replace(/{([^{}]*)}/g,
        function (a, b) {
            var r = o[b];
            return typeof r === 'string' || typeof r === 'number' ? r : a;
        }
    );
};