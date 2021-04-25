from core.models import Order,Book,Category,Cart,CartBook,Favorite
from django.contrib import admin

# Register your models here.
admin.site.register(Book)
admin.site.register(Category)
admin.site.register(Favorite)
admin.site.register(Cart)
admin.site.register(CartBook)
admin.site.register(Order)
