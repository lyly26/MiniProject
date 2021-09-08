app = angular.module("admin-app", ["ngRoute"]);


app.config(function ($routeProvider){
    $routeProvider
    .when("/product", {
        templateUrl: "/admin/product/index.html",
        controller: "product-ctrl"
    })
    
    .when("/category", {
        templateUrl: "/admin/category/index.html",
        controller: "category-ctrl"
    })

    .when("/authorize", {
        templateUrl: "/admin/authority/index.html",
        controller: "authority-ctrl"
    })

    .when("/statistical", {
        templateUrl: "/admin/statistical/index.html",
        controller: "statistical-ctrl"
    })

    .when("/unauthorized", {
        templateUrl: "/admin/authority/unauthorized.html",
        controller: "authority-ctrl"
    })
    
    .when("/account", {
        templateUrl: "/admin/account/index.html",
        controller: "account-ctrl"
    })
    
    .otherwise({
        template:"<h1 class='text-center'> FPT Polytechnic administration </h1>"
    });
});