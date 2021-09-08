app.controller("product-ctrl", function ($scope, $http) {

    $scope.items = []; // items hiện ra 
    $scope.cates = []; // form: ddtuong trong scope.form hthi lên form 
    $scope.form = {
        createDate: new Date(),
            image: 'cloud-upload.jpg',
            available: true,
    };

    //Khởi đầu
    $scope.initialize = function () { //initialize load  toàn bộ server để hiện ra
        
        //load product
        $http.get("/rest/products").then(resp => { //lấy sp
            $scope.items = resp.data;  //Lây items hiện lên table
            $scope.items.forEach(item => { //chuyển đổi ngày tháng về (chuổi)
                item.createDate = new Date(item.createDate)
            })
        }).catch(error => {
            console.log("Error", error);
        });

        //load catagory
        $http.get("/rest/categories").then(resp => {
            $scope.cates = resp.data;
        }).catch(error => {
            console.log("Error", error);
        });
    }

    //Khởi đầu
    $scope.initialize();

    //hiển thị lên form
    $scope.edit = function (item) {
        $scope.form = angular.copy(item);
        $(".nav-tabs a:eq(0)").tab('show') //gọi đến tab
    }

    //Thêm sản phẩm mới
    $scope.create = function () {
        var item = angular.copy($scope.form); //taho mới sp
        $http.post('/rest/products', item).then(resp => {
            resp.data.createDate = new Date(resp.data.createDate);
            $scope.items.push(resp.data);
            $scope.reset();
            alert("Thêm mới thành công!");
        }).catch(error => {
            alert("Lỗi thêm mới sản phẩm!");
            console.log("Error", error);
        });
    }

    //Cập nhật sản phẩm
    
    $scope.update = function () {   
        var item = angular.copy($scope.form);
        $http.put(`/rest/products/${item.id}`, item).then(resp => {
            var index = $scope.items.findIndex(p => p.id == item.id);
            resp.data.createDate = new Date(resp.data.createDate);
            $scope.items[index] = item;
            alert("Cập nhật thành công!");
        }).catch(error => {
            alert("Cập nhật thất bại!" + error)
            console.log("Error", error);
        });
    }

    //Xóa sản phẩm
    
    $scope.delete = function (item) {
        var item = angular.copy($scope.form);
        $http.delete(`/rest/products/${item.id}`).then(resp => {
            var index = $scope.items.findIndex(p => p.id == item.id);
            $scope.items.splice(index, 1);
            $scope.reset();
            alert("Xóa thành công!");
        }).catch(error => {
            alert("Xóa thất bại!" + error)
            console.log("Error", error);
        });
    }

    //Xóa form
    $scope.reset = function () {
        $scope.form = {
            createDate: new Date(), //ngày hiện tại (mặt sdidjnh)
            image: 'cloud-upload.jpg', 
            available: true, //chọn có hiệu lực ngay
        };
    }

    //Upload hình 
    $scope.imageChanged = function (files) {
        var data = new FormData();
        data.append('file', files[0]);
        $http.post('/rest/upload/images', data, {
            TransformRequest: angular.identity,
            headers: { 'Content-Type': undefined }
        }).then(resp => {
            $scope.form.image = resp.data.name;
        }).catch(error => {
            alert("Lỗi hình ảnh");
            console.log("Error", error);
        })
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