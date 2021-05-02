from rest_framework import serializers
from core.models import *
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token


class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = "__all__" 
        depth = 1


User = get_user_model()

class Userserializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id','username','password','first_name','last_name','email',)
        extra_kwargs = {'password': {"write_only":True,'required':True}}
    
    def create(self,validated_data):
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        return user

class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = "__all__" 
        

class CartBookSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartBook
        fields = "__all__" 
        depth = 1


class OrdersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = "__all__" 
        depth = 1        
