var init_gallery_slider = function(color_class) {
    var gallery = '';
    $('p.gallery-slider').each(function(i, image_container) {
        var jImg = $('img', image_container);
        if(jImg.length == 0)
            return;
        gallery += sprintf('<li class="item"> \
               <img class="image" src="%s" alt="%s"/> \
               %s \
           </li>',
           jImg.attr('src').replace('content','gallery_slider'),
           jImg.attr('alt'),
           jImg.attr('alt'));
    });

    gallery = sprintf('<div class="b-photo-slideshow"> \
           <div class="numbers"> \
               <a class="arrow prev" href="?"><b class="b-graphics b-graphics-gray-left-arrow"><b></b></b></a> \
               <strong class="slide-number"></strong> из <strong class="slides-count"></strong> \
               <a class="arrow next" href="?"><b class="b-graphics b-graphics-gray-right-arrow"><b></b></b></a> \
           </div> \
           <div class="b-gray-block %s"> \
               <ul class="b-photos">%s</ul> \
               <i class="b-corner b-corner-tl"> \
                   <i class="main-brick"></i> \
                   <i class="light-brick"></i> \
                   <i class="different-brick"></i>\
               </i> \
           </div> \
       </div>', color_class, gallery);

    $('p.gallery-slider:first').before(gallery);
    $('p.gallery-slider').remove();

    $('.b-photo-slideshow').slideShow({
        slidesContainerSelector: '.b-photos',
        slideSelector: '.b-photos .item',
        slideWidth: 536,
        numbers: true,
        colorForLinks: false
    });
}

var init_gallery_bricks = function(color_class) {
    var gallery = '';
    var count = 0;
    $('p.gallery-bricks').each(function(i, image_container) {
        var jImg = $('img', image_container);
        if(jImg.length == 0)
            return;
        gallery += sprintf('<li class="item"> \
                    <a class="link js-modal" href="%s" rel="gallery-1" title="%s"> \
                    <img class="image" src="%s" alt="%s"/> \
                </a> \
            </li>',
            jImg.attr('src'),
            jImg.attr('alt'),
            jImg.attr('src').replace('content','gallery_bricks'),
            jImg.attr('alt'));
        count++;
    });

    gallery = sprintf('<div class="b-gray-block %s"> \
                <ul class="b-gallery" title="Ещё фотографии" hide-title="Меньше фотографий">%s</ul> \
                <i class="b-corner b-corner-tl"> \
                    <i class="main-brick"></i> \
                    <i class="light-brick"></i> \
                    <i class="different-brick"></i> \
                </i> \
             </div>', color_class, gallery);

    $('p.gallery-bricks:first').before(gallery);
    $('p.gallery-bricks').remove();

    if(count > 6) {
        $('.b-gallery').desc({
            linkClass: 'link c-project-button',
            linkWrapHTML: '<div class="b-more b-more-button"></div>',
            height: 354
        });
    }
    modal.init();
}