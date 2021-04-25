from core.api.v1.serializers.serializers import *
from core.models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication

class BookView(APIView):

    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication,]

    def get(self,request):
        query = Book.objects.all()
        serializers = BookSerializer(query,many=True)
        return Response(serializers.data)