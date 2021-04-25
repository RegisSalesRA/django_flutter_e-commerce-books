from django.db import models
from django.contrib.auth.models import User


class Category(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)
    class Meta:
        verbose_name = 'Category'
        verbose_name_plural = 'Categorys'

    def _repr__(self):
        return self.title

    def __str__(self):
        return self.title

    

class Book(models.Model):
    title = models.CharField(max_length=100)
    data = models.DateField(auto_now_add=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="books/")
    marcket_price = models.PositiveIntegerField()
    selling_price = models.PositiveIntegerField()
    description = models.TextField()

    class Meta:
        verbose_name = 'Book'
        verbose_name_plural = 'Books'

    def __repr__(self):
        return self.title

    def __str__(self):
        return self.title
        


class Favorite(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.Case)
    isFavorit = models.BooleanField(default=False)

    class Meta:
        verbose_name = 'Favorite'
        verbose_name_plural = 'Favorites'

    def __repr__(self):
        return f"BookID ={self.book.id}user={self.user.username}|ISFavorite={self.isFavorit}"

    def __str__(self):
        return f"BookID ={self.book.id}user={self.user.username}|ISFavorite={self.isFavorit}"


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isComplit = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    class Meta:
        verbose_name = 'Cart'
        verbose_name_plural = 'Carts'

    def __repr__(self):
        return f"User={self.user.username}|ISComplit={self.isComplit}"

    def __str__(self):
        return f"User={self.user.username}|ISComplit={self.isComplit}"


class CartBook(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    book = models.ManyToManyField(Book)
    price = models.PositiveIntegerField()
    quantity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField()

    class Meta:
        verbose_name = 'Cart Book'
        verbose_name_plural = 'Cart Books'

    def __repr__(self):
        return f"Cart=={self.cart.id}<==>CartBook:{self.id}==Qualtity=={self.quantity}"
    
    def __str__(self):
        return f"Cart=={self.cart.id}<==>CartBook:{self.id}==Qualtity=={self.quantity}"
    



class Order(models.Model):
    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email = models.CharField(max_length=150)
    phone = models.CharField(max_length=13)
    address = models.CharField(max_length=200)

    class Meta:
        verbose_name = 'Order'
        verbose_name_plural = 'Orders'

    def __repr__(self):
        return f"Order == {self.cart.id}"
    
    def __str__(self):
        return f"Order == {self.cart.id}"