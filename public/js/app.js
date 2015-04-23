angular.module('app', ['ui.router', 'ngResource', 'app.controllers', 'app.services']);

angular.module('app').config(function($stateProvider) {
  $stateProvider
  .state('companies', { // state for showing all companies
    url: '/companies',
    templateUrl: 'partials/company/list.html',
    controller: 'CompanyListController'
  })
  .state('viewCompany', { // state for showing single company
    url: '/companies/:id/view',
    templateUrl: 'partials/company/view.html',
    controller: 'CompanyViewController'
  })
  .state('newCompany', { // state for adding a new company
    url: '/companies/new',
    templateUrl: 'partials/company/create.html',
    controller: 'CompanyCreateController'
  })
  .state('editCompany', { // state for updating a company
    url: '/companies/:id/edit',
    templateUrl: 'partials/company/edit.html',
    controller: 'CompanyEditController'
  })
  .state('newPerson', { // state for updating a company
    url: '/companies/:id/persons/new',
    templateUrl: 'partials/person/create.html',
    controller: 'PersonCreateController'
  })
  .state('editPerson', { // state for updating a company
    url: '/companies/:id/person/edit',
    templateUrl: 'partials/person/edit.html',
    controller: 'PersonEditController'
  });
}).run(function($state) {
  $state.go('companies'); // make a transition to companies state when app starts
});