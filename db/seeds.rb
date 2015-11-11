Status.create description: 'New'
Status.create description: 'Flagged'
Status.create description: 'Archived'

Driver.create name: 'B Faloona', permit_number: '24942', email: 'brandon@faloona.net', photo: 'bfaloona.png'
Driver.create name: 'Wade Hudson', permit_number: '1229', email: 'wade@wadehudson.net', photo: 'whudson.jpg'

Rating.create quality: 4, comments: 'Great!', driver_id: 1, status_id: 1
