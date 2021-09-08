app.controller("category-ctrl", function ($scope, $http) {
    $scope.items = [];
    $scope.form = {};
    //khoi dau
    $scope.initialize = function () {
        //load catagory
        $http.get("/rest/categories").then(resp => {
            $scope.items = resp.data;
        }).catch(error => {
            console.log("Error", error);
        });
    }

    $scope.initialize();

    //hien thi len form
    $scope.edit = function (item) {
        $scope.form = angular.copy(item);
        // $(".nav-tabs a:eq(0)").tab('show')
    }

    //tao moi ssan pham
    $scope.create = function () {
        var item = angular.copy($scope.form);
        $http.post('/rest/categories', item).then(resp => {
            $scope.items.push(resp.data);
            $scope.reset();
            alert("Thêm mới thành công!");
        }).catch(error => {
            alert("Thêm mới thất bại!" + error);
            console.log("Error", error);
        });
    }

    //cap nhat ssan pham
    $scope.update = function () {
        var item = angular.copy($scope.form);
        $http.put(`/rest/categories/${item.id}`, item).then(resp => {
            var index = $scope.items.findIndex(p => p.id == item.id);
            $scope.items[index] = item;
            alert("Cập nhật thành công!");
        }).catch(error => {
            alert("Cập nhật thất bại!" + error)
            console.log("Error", error);
        });
    }

    //Xoa ssan pham theo form   
    $scope.delete = function (item) {
        var item = angular.copy($scope.form);
        $http.delete(`/rest/categories/${item.id}`).then(resp => {
            var index = $scope.items.findIndex(p => p.id == item.id);
            $scope.items.splice(index, 1);
            $scope.reset();
            alert("Xóa thành công!");
        }).catch(error => {
            alert("Xóa thất bại!" + error)
            console.log("Error", error);
        });
    }

    //Xoa ssan pham theo item
    $scope.delete = function (item) {
        var item = angular.copy(item);
        $http.delete(`/rest/categories/${item.id}`).then(resp => {
            var index = $scope.items.findIndex(p => p.id == item.id);
            $scope.items.splice(index, 1);
            $scope.reset();
            alert("Xóa thành công!");
        }).catch(error => {
            alert("Xóa thất bại!" + error)
            console.log("Error", error);
        });
    }

    //xóa form
    $scope.reset = function () {
        $scope.form = {
            id: '',
            name: ''
        };
    }

    $scope.pager = {
        page: 0,
        size: 10,
        get items() {
            var start = this.page * this.size;
            return $scope.items.slice(start, start + this.size);
        },
        get count() {
            return Math.ceil(1.0 * $scope.items.length / this.size);
        },

        first() {
            this.page = 0;
        },

        prev() {
            this.page--;
            if (this.page < 0) {
                this.last();
            }
        },

        next() {
            this.page++;
            if (this.page >= this.count) {
                this.first();
            }
        },

        last() {
            this.page = this.count - 1;
        },
    }
});