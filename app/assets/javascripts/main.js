/* NG App : Stocklist */

function HomeCtrl($scope, $resource, Stocklist) {
    $scope.stocklists = Stocklist.query();
}

function StocklistCtrl($scope, $routeParams, $location, Stocklist, stocklistService) {
    var stockStatus = {};

    var stocklist = Stocklist.get({stocklistId: $routeParams.stocklistId}, function() {
        angular.forEach(stocklist.product_stocks, function(stock) {              
            var status = true;
            if (stock.quantity === null || stock.quantity <= 0) {
                status = false;
            } 
            stockStatus[stock.id] = status;
        });
    });

    $scope.stockStatus = stockStatus;
    $scope.stocklist = stocklist;
    $scope.outOfStockOnly = false

    $scope.updateStock = function(stock) {
        if (stockStatus[stock.id]) {
            stocklistService.updateStock(stock, 1);
        } else {
            stocklistService.updateStock(stock, 0);
        }
    };

    $scope.filterInStock = function(item) {
        return $scope.outOfStockOnly ? item.quantity == 0 : true;
    }
}

function ManageCtrl($scope, $routeParams, Stocklist, Product, slCategoryMap, stocklistService) {

    var stocklist = Stocklist.get({stocklistId: $routeParams.stocklistId});
    var products = Product.query({excluding: $routeParams.stocklistId});

    $scope.categories = slCategoryMap;
    $scope.stocklist = stocklist;
    $scope.products = products;

    $scope.removeProduct = function(product) {
        product.$delete(function() {
            angular.forEach(products, function(value,i) {
                if(value.id === product.id) {
                    products.splice(i,1);
                }   
            });
      
        });
    };

    $scope.remove = function(product) {
        stocklistService.removeProduct(stocklist,product,function() {
            products.push(product);      
        });        
    };

    $scope.add = function(product) {
        stocklistService.addProduct(stocklist,product, function() {
            angular.forEach(products, function(value,i) {
                if(value.id === product.id) {
                    products.splice(i,1);
                }   
            });
        }); 
    };

    $scope.category = '';
    $scope.name = '';

    $scope.addNew = function(category, name) {
        var product = new Product();
        product.name = name;
        product.category = category;
        product.$save(function(u, response) {
            $scope.add(product);
            $scope.name = ''; 
        });
    };


}

/* Init Stocklist App */
var stocklist = angular.module('stocklist',['ngResource']);

stocklist.config(['$routeProvider', function($routeProvider) {
    $routeProvider.
        when('/home', {templateUrl: 'partials/home.html', controller: HomeCtrl}).
        when('/stocklist/:stocklistId', {templateUrl: 'partials/stocklist.html', controller: StocklistCtrl}).
        when('/stocklist/:stocklistId/manage', {templateUrl: 'partials/manage.html', controller: ManageCtrl}).
        otherwise({redirectTo: '/home'});
    }
]);

// POST used for creating NEW child
// PUT  used for UPDATING 

stocklist.factory('Stocklist', function($resource) {
    return $resource('/stocklist/:stocklistId', 
                    { stocklistId: '@id', format: 'json' } );
}).service('stocklistService', function($http) {

    this.updateStock = function(stock,quantity) {
        $http.post('/product_stock/'+stock.id+'/quantity', 
           { quantity: quantity }).success(function() {
                stock.quantity = quantity;                
        });
    };

    this.addProduct = function(stocklist,product,success) {
        $http.post('/stocklist/'+stocklist.id+'/add', 
           { product_id: product.id }).success(function() {
              stocklist.product_stocks.push({ product: product});
              if (success) {
                  success();
              }
        });
    };

    this.removeProduct = function(stocklist,product,success) {
        $http.post('/stocklist/'+stocklist.id+'/remove', 
           { product_id: product.id }).success(function() {
              angular.forEach(stocklist.product_stocks, function(value, i){
                  if(value.product.id === product.id) {
                      stocklist.product_stocks.splice(i, 1);
                  }
              });
              if (success) {
                  success();
              }
        });
    };



}).factory('Product', function($resource) {
    return $resource('/products/:productId', 
                    { productId: '@id', format: 'json' } );
}).value('slCategoryMap', {
    FOOD: {tooltip: "Food Stuff", icon: 'slicon-food'},
    KGDS: {tooltip: "Kitchen Goods", icon: 'slicon-kitchen'},
    LGDS: {tooltip: "Living Goods", icon: 'slicon-living'},
    BGDS: {tooltip: "Bathroom", icon: 'slicon-bath'},
    CGDS: {tooltip: "Cleaning Goods", icon: 'slicon-cleaning'}
}).directive('slCategory', function(slCategoryMap) {
    return {
        replace: true,
        restrict: 'EA',
        scope: { name: '=name' },
        template: '<i class="{{icon}}"></i>',
        link: function(scope, element, attrs) {
            scope.icon = slCategoryMap[scope.name].icon;
            scope.tooltip = slCategoryMap[scope.name].tooltip;
        }
    };
}).directive('slTypeahead', function() {
    return {
        replace: true,
        restrict: 'EA',
        scope: { source: '=source', 
                 updater: '=updater' },
        template: '<input type="text" >',
        link: function(scope, element, attrs) {
            $(element).typeahead({
                source: function(query) {
                    var results = [];
                   
                    angular.forEach(scope.source, function(item) {
                        results.push(item.name);
                    });

                    return results;
                },
                updater: function(item) {
                    scope.updater(item);
                    scope.$apply();
                }
            });
        }
    };
});



