var init_gallery_slider = function() {
    var gallery = '';
    $('p.gallery-slider').each(function(i, image_container) {
      gallery += sprintf('<li class="item"> \
               <img class="image" src="%s" alt="%s"/> \
               %s \
           </li>',
        $('img', image_container).attr('src').replace('content','gallery_slider'),
        $('img', image_container).attr('alt'),
        $('img', image_container).attr('alt'));
    });

    gallery = sprintf('<div class="b-photo-slideshow"> \
           <div class="numbers"> \
               <a class="arrow prev" href="?"><b class="b-graphics b-graphics-gray-left-arrow"><b></b></b></a> \
               <strong class="slide-number"></strong> из <strong class="slides-count"></strong> \
               <a class="arrow next" href="?"><b class="b-graphics b-graphics-gray-right-arrow"><b></b></b></a> \
           </div> \
           <div class="b-gray-block"> \
               <ul class="b-photos">%s</ul> \
               <i class="b-corner b-corner-tl"> \
                   <i class="main-brick"></i> \
                   <i class="light-brick"></i> \
                   <i class="different-brick"></i>\
               </i> \
           </div> \
       </div>', gallery);

    $('p.gallery-slider:first').before(gallery);
    $('p.gallery-slider').remove();
//            $('.slider-item:first').addClass('current');
//            $('.slider-list').css({height: undefined});

    $('.b-photo-slideshow').slideShow({
        slidesContainerSelector: '.b-photos',
        slideSelector: '.b-photos .item',
        slideWidth: 536,
        numbers: true,
        colorForLinks: false
    });
}


var init_gallery_bricks = function() {
    var gallery = '';
    $('p.gallery-bricks').each(function(i, image_container) {
      gallery += sprintf('<li class="item"> \
                <a class="link js-modal" href="%s" rel="gallery-1" title="%s"> \
                <img class="image" src="%s" alt="%s"/> \
            </a> \
        </li>',
        $('img', image_container).attr('src'),
        $('img', image_container).attr('alt'),
        $('img', image_container).attr('src').replace('content','gallery_bricks'),
        $('img', image_container).attr('alt'));
    });

    gallery = sprintf('<div class="b-gray-block"> \
                <ul class="b-gallery" title="Ещё фотографии" hide-title="Меньше фотографий">%s</ul> \
                <i class="b-corner b-corner-tl"> \
                    <i class="main-brick"></i> \
                    <i class="light-brick"></i> \
                    <i class="different-brick"></i> \
                </i> \
            </div>', gallery);

    $('p.gallery-bricks:first').before(gallery);
    $('p.gallery-bricks').remove();
//            $('.slider-item:first').addClass('current');
//            $('.slider-list').css({height: undefined});

    $('.b-gallery').desc({
        linkClass: 'link c-project-button',
        linkWrapHTML: '<div class="b-more b-more-button"></div>',
        height: 354
    });
}