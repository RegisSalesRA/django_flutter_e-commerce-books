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
        