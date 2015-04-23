angular.module('app.services', [])

.factory('Company', function($resource) {
	return $resource('/api/v1/companies/:id', { 
		id: '@id'
	}, {
		save: {
			method: 'POST'
	    },
    	update: {
			method: 'PUT'
	    },
		delete: {
			method: 'DELETE'
		}
	});
})

.factory('Person', function($resource) {
  return $resource('http://localhost:9393/api/v1/companies/:company_id/persons/:person_id', { 
	company_id: '@company_id', 
	person_id: '@person_id'
  }, {
    update: {
      method: 'PUT'
    }
  });
})

.service('popupService', function($window) {
    this.showPopup = function(message){
        return $window.confirm(message);
    }
});
