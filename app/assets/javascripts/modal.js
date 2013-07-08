/*
 * Модальное окно
 */

var modal = (function () {
	var SETTINGS = {
		showLinksSelector: 'a.js-modal',
		modalClassForHtml: 'l-theater',
		modalHtml:
			'<div class="l-modal"> \
				<div class="l-modal-outer"> \
					<div class="l-modal-inner"> \
						<div class="l-modal-container"></div> \
					</div> \
				</div> \
			</div>',
		modalOuterSelector: '.l-modal-outer',
		modalInnerSelector: '.l-modal-container',
		hideLinkSelector: '.b-close-modal',
		gallery: {
			html:
				'<div class="b-modal-gallery"> \
					<a class="b-close-modal" href="?"> \
						<b class="b-icon b-icon-close"><b>Закрыть</b></b> \
					</a> \
					<a class="b-graphics b-graphics-prev" href="?"><b></b></a> \
					<a class="b-graphics b-graphics-next" href="?"><b></b></a> \
					<div class="slide"> \
						<img class="image"/> \
						<em class="label"></em> \
					</div> \
				</div>',
			singleClass: 'b-modal-gallery-single',
			slideSelector: '.slide',
			imageSelector: '.image',
			labelSelector: '.label',
			wideImageClass: 'wide-image',
			tallImageClass: 'tall-image',
			nearImagesPosition: 266,
			prevControlSelector: '.b-graphics-prev',
			prevControlDisabledClass: 'b-graphics-disabled-prev',
			nextControlSelector: '.b-graphics-next',
			nextControlDisabledClass: 'b-graphics-disabled-next',
			animationTime: 500
		}
	};
	
	var _html, _body, _container, _outer, _inner,
		_showLinks, _showLinksGroup, _hideLink,
		_gallery, _inlineContainer;
	
	function prepareHtml(){
		_container = $(SETTINGS.modalHtml);
		_outer = $(SETTINGS.modalOuterSelector, _container);
		_inner = $(SETTINGS.modalInnerSelector, _container);
		_hideLink = $(SETTINGS.hideLinkSelector);
		
		_body.append(_container);
	}
	
	function assignEvents(){
		_showLinks.live('click', function(event){
			var thisLink = $(this);
			
			showContents(thisLink.attr('href'), thisLink.attr('rel'), thisLink.attr('title'), thisLink);
			showContainer();
			
			event.preventDefault();
		});
		
		_hideLink.live('click', function(event){
			clearContents();
			hideContainer();
			
			event.preventDefault();
		});
		
		_body.keyup(function(event){
			var keycode = (event == null) ? event.keyCode : event.which;
			
			if( keycode == 27 ){
				_hideLink.click();
			}
		});
	}
	
	function showContents(url, group, title, link){
		var urlWithoutQuery = url,
			queryPosition = url.indexOf('?'),
			typeRegexp = /\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$|\.html$|\.htm$/;
		
		if( queryPosition != -1 ){
			urlWithoutQuery = url.substring(0, queryPosition);
		}
		
		var urlType = urlWithoutQuery.toLowerCase().match(typeRegexp);
		
		if( urlType == '.jpg' || urlType == '.jpeg' || urlType == '.png' || urlType == '.gif' ){
			_gallery = {};
			_gallery.container = $(SETTINGS.gallery.html);
			
			if( group ){
				_showLinksGroup = _showLinks.filter('[rel=' + group + ']');
				_gallery.index = _showLinksGroup.index(link);
				_gallery.slides = new Array(_showLinksGroup.length);
				
				_gallery.slides[_gallery.index] = {
					container: $(SETTINGS.gallery.slideSelector, _gallery.container),
					image: $(SETTINGS.gallery.imageSelector, _gallery.container),
					label: $(SETTINGS.gallery.labelSelector, _gallery.container)
				}
				_gallery.slideClone = _gallery.slides[_gallery.index].container.clone();
				loadGalleryImage(_gallery.slides[_gallery.index], url, title, 'center');
				
				loadGallerySlide(_gallery.index + 1);
				loadGallerySlide(_gallery.index - 1);
				loadGallerySlide(_gallery.index + 2);
				loadGallerySlide(_gallery.index - 2);
				
				_gallery.prevControl = $(SETTINGS.gallery.prevControlSelector, _gallery.container);
				_gallery.nextControl = $(SETTINGS.gallery.nextControlSelector, _gallery.container);
				
				//manageGalleryControls();
				assignGalleryEvents();
			}
			else{
				_gallery.slide = {
					container: $(SETTINGS.gallery.slideSelector, _gallery.container),
					image: $(SETTINGS.gallery.imageSelector, _gallery.container),
					label: $(SETTINGS.gallery.labelSelector, _gallery.container)
				};
				
				loadGalleryImage(_gallery.slide, url, title, 'center');
				
				_gallery.container.addClass(SETTINGS.gallery.singleClass);
			}
			
			alignImagesOnResize();
			
			_container.append(_gallery.container);
			_outer.hide();
			_hideLink = $(SETTINGS.hideLinkSelector);
		}
		else if( urlType == '.html' || urlType == '.htm' ) {
			_inner.load(url += '&random=' + (new Date().getTime()));
		}
		else if( url.substr(0, 1) == '#' ){
			_inlineContainer = $(url);
			
			if( _inlineContainer.length ){
				_inner.append(_inlineContainer.children());
			}
		}
	}
	
	function loadGallerySlide( index ){
		if( index >= 0 && index < _gallery.slides.length && typeof _gallery[index] === 'undefined' ){
			var imageAlign = (index > _gallery.index) ? 'left' : 'right',
				slidePosition = (index - _gallery.index) + '00%';
			
			_gallery.slides[index] = {
				container: _gallery.slideClone.clone()
			}
			
			_gallery.slides[index].container.css('left', slidePosition).appendTo(_gallery.container);
			_gallery.slides[index].image = $(SETTINGS.gallery.imageSelector, _gallery.slides[index].container);
			_gallery.slides[index].label = $(SETTINGS.gallery.labelSelector, _gallery.slides[index].container);
			
			loadGalleryImage(_gallery.slides[index], _showLinksGroup.eq(index).attr('href'), _showLinksGroup.eq(index).attr('title'), imageAlign);
		}
	}
	
	function loadGalleryImage(slide, url, title, horizontalAlign){
		slide.image
			.hide()
			.load(function(){
				alignGalleryImage(slide.container, slide.image, horizontalAlign);
				slide.image.show();
				slide.label.text(title);
			})
			.attr('src', url);
	}
	
	function alignGalleryImage(container, image, horizontalAlign){
		var imageWidth = 0,
			imageHeight = 0,
			descreasingRatio = 1;
		
		if( typeof image.data('width') !== 'undefined' ){
			imageWidth = image.data('width');
			imageHeight = image.data('height');
		}
		else{
			imageWidth = image.width();
			imageHeight = image.height();
			
			image.data('width', imageWidth);
			image.data('height', imageHeight);
		}
		
		if( container.width() / container.height() < imageWidth / imageHeight ){
			if( container.width() < imageWidth ){
				descreasingRatio = container.width() / imageWidth;
				image.removeClass(SETTINGS.gallery.tallImageClass).addClass(SETTINGS.gallery.wideImageClass);
			}
			else{
				image.css('margin-left', (container.width() - imageWidth) / 2);
			}
			
			if( horizontalAlign == 'left' ) {
				image.css('margin-left', -SETTINGS.gallery.nearImagesPosition);
			}
			else if( horizontalAlign == 'right' ) {
				image.css('margin-left', container.width() - imageWidth * descreasingRatio + SETTINGS.gallery.nearImagesPosition);
			}
			
			image.css('margin-top', (container.height() - imageHeight * descreasingRatio) / 2);
		}
		else{
			if( container.height() < imageHeight ){
				descreasingRatio = container.height() / imageHeight;
				image.removeClass(SETTINGS.gallery.wideImageClass).addClass(SETTINGS.gallery.tallImageClass);
			}
			else{
				image.css('margin-top', (container.height() - imageHeight ) / 2);
			}
			
			if( horizontalAlign == 'center' ){
				image.css('margin-left', (container.width() - imageWidth * descreasingRatio) / 2);
			}
			else if( horizontalAlign == 'left' ) {
				image.css('margin-left', -SETTINGS.gallery.nearImagesPosition);
			}
			else if( horizontalAlign == 'right' ) {
				image.css('margin-left', container.width() - imageWidth * descreasingRatio + SETTINGS.gallery.nearImagesPosition);
			}
		}
	}
	
	function alignImagesOnResize(){
		$(window).resize(function(){
			if( typeof _gallery.slide === 'object' ){
			}
			else if( typeof _gallery.slides === 'object' ){
				// Полная жесть с выравниванием
				alignGalleryImage(_gallery.slides[_gallery.index].container, _gallery.slides[_gallery.index].image, 'center');
				
				if( _gallery.index > 0 ){
					alignGalleryImage(_gallery.slides[_gallery.index - 1].container, _gallery.slides[_gallery.index - 1].image, 'right');
				}
				if( _gallery.index < _gallery.slides.length - 1 ){
					alignGalleryImage(_gallery.slides[_gallery.index + 1].container, _gallery.slides[_gallery.index + 1].image, 'left');
				}
			}
		});
	}
	
	/*
	function manageGalleryControls(){
		if( _showLinksGroup.length > 1 ){
			if( _currentLink == 0 ){
				_gallery.prevControl.addClass(SETTINGS.gallery.prevControlDisabledClass);
			}
			else{
				_gallery.prevControl.removeClass(SETTINGS.gallery.prevControlDisabledClass);
			}
			
			if( _currentLink == _showLinksGroup.length - 1 ){
				_gallery.nextControl.addClass(SETTINGS.gallery.nextControlDisabledClass);
			}
			else{
				_gallery.nextControl.removeClass(SETTINGS.gallery.nextControlDisabledClass);
			}
		}
		else{
			_gallery.container.addClass(SETTINGS.gallery.singleClass);
		}
	}
	*/
	
	function assignGalleryEvents(){
		_gallery.prevControl.click(function(event){
			if( _gallery.index > 0 && !_gallery.container.data('animating') ){
				_gallery.container.data('animating', true);
				
				if( _gallery.index > 1 ){
					_gallery.slides[_gallery.index - 2].container.animate({ left: '-100%' }, SETTINGS.gallery.animationTime);
				}
				_gallery.slides[_gallery.index - 1].container.animate({ left: '0' }, SETTINGS.gallery.animationTime);
				_gallery.slides[_gallery.index].container.animate({ left: '100%' }, SETTINGS.gallery.animationTime);
				
				_gallery.slides[_gallery.index - 1].image.animate({
					marginLeft: (_gallery.slides[_gallery.index - 1].container.width() - _gallery.slides[_gallery.index - 1].image.width()) / 2
				}, SETTINGS.gallery.animationTime);
				
				if( _gallery.index < _gallery.slides.length - 1 ){
					_gallery.slides[_gallery.index + 1].container.animate({ left: '200%' }, SETTINGS.gallery.animationTime);
				}
				
				_gallery.slides[_gallery.index].image.animate({
					marginLeft: -SETTINGS.gallery.nearImagesPosition
				}, SETTINGS.gallery.animationTime, function(){
					loadGallerySlide(_gallery.index - 3);
					
					_gallery.index--;
					_gallery.container.data('animating', false);
				});
			}
			
			event.preventDefault();
		});
		
		_gallery.nextControl.click(function(event){
			if( _gallery.index < _gallery.slides.length - 1 && !_gallery.container.data('animating') ){
				_gallery.container.data('animating', true);
				
				if( _gallery.index > 0 ){
					_gallery.slides[_gallery.index - 1].container.animate({ left: '-200%' }, SETTINGS.gallery.animationTime);
				}
				_gallery.slides[_gallery.index].container.animate({ left: '-100%' }, SETTINGS.gallery.animationTime);
				_gallery.slides[_gallery.index + 1].container.animate({ left: '0' }, SETTINGS.gallery.animationTime);
				
				_gallery.slides[_gallery.index].image.animate({
					marginLeft: _gallery.slides[_gallery.index].container.width() - _gallery.slides[_gallery.index].image.width() + SETTINGS.gallery.nearImagesPosition
				}, SETTINGS.gallery.animationTime);
				
				if( _gallery.index < _gallery.slides.length - 2 ){
					_gallery.slides[_gallery.index + 2].container.animate({ left: '100%' }, SETTINGS.gallery.animationTime);
				}
				
				_gallery.slides[_gallery.index + 1].image.animate({
					marginLeft: (_gallery.slides[_gallery.index + 1].container.width() - _gallery.slides[_gallery.index + 1].image.width()) / 2
				}, SETTINGS.gallery.animationTime, function(){
					loadGallerySlide(_gallery.index + 3);
					
					_gallery.index++;
					_gallery.container.data('animating', false);
				});
			}
			
			event.preventDefault();
		});
	}
	
	function clearContents(){
		if( typeof _inlineContainer === 'object' && _inlineContainer.hasOwnProperty('length') && _inlineContainer.length ){
			_inlineContainer.append(_inner.children());
			_inlineContainer = '';
		}
		if( typeof _gallery === 'object' && _gallery.hasOwnProperty('container') ){
			_gallery.container.remove();
			_outer.show();
		}
		
		_inner.html('');
	}
	
	function showContainer(){
		if( $.browser.mozilla ){
			_body.addClass(SETTINGS.modalClassForHtml);
		}
		else{
			if( $.browser.msie && $.browser.version == '6.0' ){
				_html.scrollTop(0);
			}
			_html.addClass(SETTINGS.modalClassForHtml);
		}
		
		_container.show();
	}
	
	function hideContainer(){
		if( $.browser.mozilla ){
			_body.removeClass(SETTINGS.modalClassForHtml);
		}
		else{
			_html.removeClass(SETTINGS.modalClassForHtml);
		}
		
		_container.hide();
	}
	
	return {
		init: function(userSettings){
			$.extend(SETTINGS, userSettings);
			
			_html = $(document.documentElement);
			_body = $(document.body);
			_showLinks = $(SETTINGS.showLinksSelector);
			
			prepareHtml();
			assignEvents();
		},
		show: function(url){
			showContents(url);
			showContainer();
		},
		hide: function(){
			clearContents();
			hideContainer();
		}
	};
})();

$(function(){
	modal.init();
});