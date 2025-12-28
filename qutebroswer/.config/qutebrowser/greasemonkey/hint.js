(function() {
    'use strict';

    const old_add_event_listener = Element.prototype.addEventListener;
    Element.prototype.addEventListener = function() {
        if (arguments[0] === 'click') {
            this.classList.add('.qutebrowser-custom-click');
        }
        return old_add_event_listener.apply(this, arguments)
    }
})()
