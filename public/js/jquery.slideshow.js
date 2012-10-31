(function($){
	$.fn.slideShow = function( userSettings ){
		var SETTINGS = {
			slidesContainerSelector: '.slides',
			slideSelector: '.slide',
			prevLinkSelector: '.prev',
			nextLinkSelector: '.next',
			dotsContainerSelector: '.previews',
			dotSelector: '.preview',
			dotSample: '<a class="preview c-{color}-link c-{color}-block" href="?"><span class="number">{number}</span></a>',
			dotSelectedClass: 'selected',
			slideBy: 1,
			slidePerPage: 1,
			slideWidth: 699,
			slideDistance: 0,
			animationTime: 300,
			slideFromKeyboard: false,
			dots: false
		};
		
		return this.each(function(){
			if( userSettings ){
				$.extend( SETTINGS, userSettings );
			}
			
			var container = $(this),
				slidesContainer = $(SETTINGS.slidesContainerSelector, container),
				slides = $(SETTINGS.slideSelector, container),
				prevLink = $(SETTINGS.prevLinkSelector, container),
				nextLink = $(SETTINGS.nextLinkSelector, container),
				slidesCount = slides.length,
				currentPage = 0;
			
			if( SETTINGS.dots && slidesCount > 1 ){
				var dotsContainer = $(SETTINGS.dotsContainerSelector, container);
					dots = $(SETTINGS.dotSelector, dotsContainer);
				
				prepareDots();
			}
			
			manageLinks();
			assignEvents();
			
			function prepareDots(){
				var dotsHtml = '';
				
				for( var i = 0; i < slidesCount; i++ ){
					dotsHtml += SETTINGS.dotSample.supplant({
						color: slides.eq(i).attr('color-code'),
						number: i + 1
					});
				}
				
				dotsContainer.html(dotsHtml);
				dots = $(SETTINGS.dotSelector, dotsContainer);
			}
			
			function manageLinks(){
				if( currentPage == 0 ){
					prevLink.fadeOut();
				}
				else{
					prevLink.fadeIn();
					
					if( SETTINGS.slidePerPage == 1 ){
						prevLink.removeClass().addClass('prev c-' + slides.eq(currentPage - 1).attr('color-code') + '-link');
					}
				}
				if( slidesCount < SETTINGS.slidePerPage || currentPage == (Math.ceil((slidesCount - SETTINGS.slidePerPage + SETTINGS.slideBy) / SETTINGS.slideBy) - 1) ){
					nextLink.fadeOut();
				}
				else{
					nextLink.fadeIn();
					
					if( SETTINGS.slidePerPage == 1 ){
						nextLink.removeClass().addClass('next c-' + slides.eq(currentPage + 1).attr('color-code') + '-link');
					}
				}
				
				if( SETTINGS.dots && slidesCount > 1 ){
					dots.removeClass(SETTINGS.dotSelectedClass);
					dots.eq(currentPage).addClass(SETTINGS.dotSelectedClass);
				}
			}
			
			function assignEvents(){
				prevLink.click(function(event){
					if( currentPage > 0 ){
						currentPage--;
						switchSlide();
					}
					
					event.preventDefault();
				});
				
				nextLink.click(function(event){
					if( currentPage < (Math.ceil((slidesCount - SETTINGS.slidePerPage + SETTINGS.slideBy) / SETTINGS.slideBy) - 1) ){
						currentPage++;
						switchSlide();
					}
					
					event.preventDefault();
				});
				
				if( SETTINGS.slideFromKeyboard ){
					$(document).keyup(function(event){
						var keycode = (event == null) ? event.keyCode : event.which;
						
						if( keycode == 37 ){
							prevLink.click();
						}
						if( keycode == 39 ){
							nextLink.click();
						}
					});
				}
				
				if( SETTINGS.dots && slidesCount > 1 ){
					dots.click(function(event){
						var thisIndex = $(this).index();
						
						if( thisIndex != currentPage ){
							currentPage = thisIndex;
							switchSlide();
						}
						
						event.preventDefault();
					});
				}
			}
			
			function switchSlide(){
				slidesContainer.animate({
					marginLeft: currentPage * (SETTINGS.slideWidth + SETTINGS.slideDistance) * SETTINGS.slideBy * -1
				}, SETTINGS.animationTime);
				
				if( SETTINGS.dots ){
					dotsContainer.animate({
						marginLeft: currentPage * 38 * -1
					}, SETTINGS.animationTime);
				}
				
				manageLinks();
			}
		});
	};
})( jQuery );