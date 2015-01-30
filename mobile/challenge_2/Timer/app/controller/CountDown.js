var count = 0;

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
        count += 5;
        this.getMainbtn().setText(count);
    },
    onTen: function() {
        this.getMainbtn().setHidden(false);
        count += 10;
        this.getMainbtn().setText(count);
    },
    onThirty: function() {
        this.getMainbtn().setHidden(false);
        count += 30;
        this.getMainbtn().setText(count);
    },
    onSixty: function() {
        this.getMainbtn().setHidden(false);
        count += 60;
        this.getMainbtn().setText(count);

    },
    onMainBtn: function() {
        task.delay(count*1000);
    }
});

var task = Ext.create('Ext.util.DelayedTask', function() {
    count = 0;
    Timer.app.getController('CountDown').getMainbtn().setHidden(true);
    Ext.Msg.alert('', 'Back to work minion!', Ext.emptyFn);
});
