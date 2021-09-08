var app = angular.module('shopping-cart-app', []); //Chỉ ra ứng dụng nằm ở đâu
app.controller('ctrl', function($scope, $http) {

	/*---------QUẢN LÝ GIỎ HÀNG----------------*/

	$scope.cart = {
		items: [],

		//Thêm sản phẩm vào giỏ hàng
		add(id) {
			var item = this.items.find(item => item.id === id); // kiểm tra id nhập vào có tồn tại trong giỏ hàng hay chưa
			if (item) {//nếu mặt hàng có mã giống
				item.qty++; //tăng số lượng
				this.saveToLocalStorage(); //lưu vào local
			} else // nếu chưa tồn tại trong giỏ hàng
				$http.get(`/rest/products/${id}`).then(response => {//tải trên server về --thông qua API 
					response.data.qty = 1; // set sl = 1
					this.items.push(response.data); // push vào mảng
					this.saveToLocalStorage();
				})
		},

		//Xóa sản phẩm vào giỏ hàng
		remove(id) {
			var index = this.items.findIndex(item => item.id == id); //vị trí sp nằm trong giỏ hàng qua id
			this.items.splice(index, 1); //splice xóa ptu khỏi mảng
			this.saveToLocalStorage(); //Luuw
		},

		//Xóa sacjch các mặt hàng trong giỏ hàng
		clear() {
			this.items = []; //cho mảng = rỗng 
			this.saveToLocalStorage(); //Lưu

		},

		//Tính thành tiền của 1 sản phẩm
		amt_of(item) { },

		//Tính tổng số lượng các mặt hàng trong giỏ
		get count() {
		
			return this.items.map(item => item.qty).reduce((total, qty) => total += qty, 0);

			// lấy ra số lượng trên mỗi sản phẩm
			// rồi cộng lại 

		},
		get amount() { //Tổng thành tiền các mặt hàng trong giỏ hàng

			return this.items.map(item => item.qty * item.price).reduce((total, qty) => total += qty, 0);

			// lấy ra số lượng * đơn giá trên mỗi sản phẩm
			// rồi cộng lại 


		},
		loadLocalStorage() { //Lưu giỏ hàng vào local storage
			var json = localStorage.getItem("cart");
			
			this.items = json ? JSON.parse(json) : [];
			// nếu dữ liệu trong local của Items có thì gán vào danh sách Items, ngược lại gán []
		},

		saveToLocalStorage() { //Đọc giỏ hàng từ local storage
			var json = JSON.stringify(angular.copy(this.items)); // thực hiện chuyển mảng items sang json 
			
			localStorage.setItem("cart", json); // lưu vào localStorage
		}
	}
	$scope.cart.loadLocalStorage();

	$scope.order = {
		createDate: new Date(),
		address: "",
		account: {
			username: $("#username").text()
		},
		get orderDetails() {
			return $scope.cart.items.map(item => {
				return {
					product: { id: item.id },
					price: item.price,
					quantity: item.qty
				}
			})
		},
		purchase() {
			var order = angular.copy(this);
			// Thực hiện đặt hàng

			$http.post("/rest/orders", order).then(resp => {
				alert("Đặt hàng thành công")
				$scope.cart.clear();
				location.href = "/order/detail/" + resp.data.id;
			}).catch(erro => {
				alert("Đặt hàng lỗi")
				console.log(erro)
			})
		}
	}
})