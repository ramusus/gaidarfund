/*
 * Табы
 */

(function($){
    $.fn.tabs = function( userSettings ){
        var SETTINGS = {
            linkSelector: '',
            tabSelector: '',
            selectedClass: 'selected',
            animation: {
                type: '',
                time: 0
            },
            generateMenu: false,
            onSwitchTab: null
        };

        return this.each(function(){
            if( userSettings ){
                $.extend( SETTINGS, userSettings );
            }

            var tabsContainer = $(this),
                tabs = $(SETTINGS.tabSelector, tabsContainer),
                tabsParent = tabs.eq(0).parent(),
                openedTab;

            if( SETTINGS.generateMenu ){
                generateMenu();

                var links = $('.b-tab-menu .link', tabsContainer);
            }
            else{
                var links = $(SETTINGS.linkSelector, tabsContainer);
            }

            initTabs();
            assignEvents();

            function generateMenu(){
                // HTML для генерируемого меню зашит здесь
                var menuString = '<ul class="b-tab-menu b-tab-menu-compact">';

                for( var i = 0; i < tabs.length; i++ ){
                    menuString += '<li class="item"><a class="link" href="#article-tab-' + i + '">' + tabs.eq(i).attr('title') + '</a></li>';
                    tabs.eq(i).attr('id', 'article-tab-' + i).removeAttr('title');
                }

                menuString += '</ul>';

                $(menuString).prependTo(SETTINGS.tabSelector);
            }

            function initTabs(){
                var selectedLink = links.filter('.selected').first();

                if( selectedLink.length ){
                    openedTab = tabByLink( selectedLink );
                    switchTab( selectedLink );
                }
                else{
                    openedTab = tabByLink( links.first() );
                    switchTab( links.first() );
                }
            }

            function assignEvents(){
                links.click(
                    clickHandler
                );

                // Shit hack. Нужен для того, чтобы просто переключить таб, без вызова callback-функции
                links.bind(
                    'clickOnly',
                    clickOnlyHandler
                );
            }

            function clickHandler( event ){
                event.preventDefault();

                switchTab( $(this) );

                if( $.isFunction(SETTINGS.onSwitchTab) )
                    SETTINGS.onSwitchTab.call(this, event);
            }

            function clickOnlyHandler( event ){
                event.preventDefault();

                switchTab( $(this) );
            }

            function switchTab( link ) {
                var targetTab = tabByLink( link );

                if( SETTINGS.animation.type == 'horizontal' ){
                    tabsParent.animate({
                        marginLeft: - targetTab.position().left
                    }, SETTINGS.animation.time);
                }
                else if( SETTINGS.animation.type == 'tabSize' ){
                    var targetTabWidth = targetTab.width(),
                        targetTabHeight = targetTab.height();

                    tabs.hide();

                    targetTab.width( openedTab.width() );
                    targetTab.height( openedTab.height() );

                    targetTab.show().animate({
                        width: targetTabWidth,
                        height: targetTabHeight
                    }, SETTINGS.animation.time);
                }
                else{
                    tabs.hide();
                    targetTab.show();
                }

                openedTab = targetTab;

                links.removeClass(SETTINGS.selectedClass);
                link.addClass(SETTINGS.selectedClass);

                // Когда есть дублирующие ссылки
                links.filter(function(){return $(this).attr('href') == link.attr('href')}).addClass(SETTINGS.selectedClass);
            }

            function tabByLink( link ){
                return tabs.filter(function(){
                    return $(this).attr('id') == link.attr('href').substr(1);
                });
            }
        });
    };
})( jQuery );