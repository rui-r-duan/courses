Ext.define('Timer.controller.CountDown', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            five: '#five',
            ten: '#ten',
            thirty: '#thirty',
            sixty: '#sixty',
            mainbtn: '#count'
        },
        control: {
            five: {
                tap: 'onFive'
            },
            ten: {
                tap: 'onTen'
            },
            thirty: {
                tap: 'onThirty'
            },
            sixty: {
                tap: 'onSixty'
            },
            mainbtn: {
                tap: 'onMainBtn'
            }
        }
    },

    onFive: function() {
        this.getMainbtn().setHidden(false);
        this.getMainbtn().setText('5');
    },
    onTen: function() {
        this.getMainbtn().setText('10');
    },
    onThirty: function() {
        this.getMainbtn().setText('30');
    },
    onSixty: function() {
        this.getMainbtn().setText('60');

    },
    onMainBtn: function() {
        console.log('start count down');
    }
});
