Ext.define('Timer.controller.CountDown', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            hiddenbutton: '#count'
        },
        control: {
            hiddenbutton: {
                tap: 'doLogin'
            }
        }
    },

    doLogin: function() {
        alert('clicked me');
    }
});
