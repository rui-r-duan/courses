Ext.define('Timer.view.Main', {
    extend: 'Ext.Container',
    xtype: 'main',
    requires: [
        'Ext.TitleBar'
    ],
    config: {
        layout: {
            type: 'vbox'
        },

        items: [
            {
                title: 'Coffee Break',
                iconCls: 'action',

                items: [
                    {
                        docked: 'top',
                        xtype: 'titlebar',
                        title: 'Coffee Break'
                    },
                    {
                        xtype: 'button',
                        text: '5',
                        id: 'five'
                    },
                    {
                        xtype: 'button',
                        text: '10',
                        id: 'ten'
                    },
                    {
                        xtype: 'button',
                        text: '30',
                        id: 'thirty'
                    },
                    {
                        xtype: 'button',
                        text: '60',
                        id: 'sixty'
                    },
                    {
                        xtype: 'button',
                        text: 'Hidden',
                        id: 'count',
                        hidden: true
                    }
                ]
            }
        ]
    }
});
