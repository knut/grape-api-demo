angular.module('app.controllers', [])

.controller('CompanyListController', function($scope, $state, popupService, $window, Company) {
  
	$scope.data = {};
	
	Company.query(function(response) { // fetch all companies. Issues a GET to /api/v1/companies
		$scope.data.companies = response;
	});

	$scope.deleteCompany = function(company) { // Delete a company. Issues a DELETE to /api/v1/companies/:id
    	if (popupService.showPopup('Are you sure?')) {
      		company.$delete(function() {
        		$window.location.href = ''; // redirect to home
      		});
    	}
  	};
})

.controller('CompanyViewController', function($scope, $stateParams, popupService, $window, Company) {
	$scope.company = {};
	$scope.company = Company.get({ id: $stateParams.id }); // Get a single company. Issues a GET to /api/v1/companies/:id
	// $scope.persons = $scope.company.persons;
	
	console.log($scope.company);
	
	$scope.getFile = function(person) {
		
	};
	
	$scope.deletePerson = function(person) { // Delete a person. Issues a DELETE to /api/v1/companies/:id
    	if (popupService.showPopup('Are you sure?')) {
      		/*person.$delete(function() {
        		$window.location.href = ''; // redirect to home
      		});*/
			
			
    	}
  	};
	
})

.controller('CompanyCreateController', function($scope, $state, $stateParams, Company) {
  $scope.company = new Company();  // create new company instance. Properties will be set via ng-model on UI
 
  $scope.addCompany = function() { // create a new company. Issues a POST to /api/v1/companies
    $scope.company.$save(function() {
      $state.go('companies'); // on success go back to home i.e. companies state.
    });
  };
})

.controller('CompanyEditController', function($scope, $state, $stateParams, Company) {
  $scope.updateCompany = function() { // Update the edited movie. Issues a PUT to /api/companies/:id
    $scope.company.$update(function() {
      $state.go('companies'); // on success go back to home i.e. companies state.
    });
  };
 
  $scope.loadCompany = function() { // Issues a GET request to /api/v1/companies/:id to get a company to update
    $scope.company = Company.get({ id: $stateParams.id });
  };
 
  $scope.loadCompany(); // Load a company which can be edited on UI
})


.controller('PersonCreateController', function($scope, $state, $stateParams, Person) {
  // $scope.company = new Company();  // create new company instance. Properties will be set via ng-model on UI
 
  console.log($stateParams);

  $scope.person = new Person();
  $scope.person.company_id = $stateParams.id;
  console.log($scope.person);

  $scope.addPerson = function() {
    $scope.person.$save(function() {
	  console.log($scope.person);
      $state.go('companies');
    });
  };
})

.controller('PersonEditController', function($scope, $state, $stateParams, Person) {
	$scope.updatePerson = function() { // Update the edited movie. Issues a PUT to /api/companies/:id
	    $scope.person.$update(function() {
	      $state.go('companies'); // on success go back to home i.e. companies state.
	    });
	  };

	  $scope.loadPerson = function() { // Issues a GET request to /api/v1/companies/:id to get a company to update
	    $scope.person = Person.get({ company_id: $stateParams.company_id, id: $stateParams.id });
	  };

	  $scope.loadPerson(); // Load a company which can be edited on UI
})

;
