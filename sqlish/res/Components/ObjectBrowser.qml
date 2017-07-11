import QtQuick 2.4

Accordion {
	anchors.fill: parent
	anchors.margins: 10
	visible: true

	model: [
		{
			"label": "Cash",
			'value':'$4418.28',
			'children': [
				{
					'label': 'Float',
					'value': '$338.72'
				},
				{
					'label': 'Cash Sales',
					'value': '$4059.56'
				},
				{
					'label': 'In/Out',
					'value': '-$50.00',
					'children': [
						{
							'label': 'coffee/creamer',
							'value': '-$40.00'
						},
						{
							'label': 'staples & paper',
							'value': '-$10.00'
						}

					]
				}

			]
		},
		{
			'label': 'Card',
			'value': '$3314.14',
			'children': [
				{
					'label': 'Debit',
					'value': '$1204.04'
				},
				{
					'label': 'Credit',
					'value': '$2110.10'
				}
			]
		}

	]
}
