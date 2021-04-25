from rest_framework import serializers
from core.models import *

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = "__all__" 
        depth = 1