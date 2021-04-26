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
        data = []
        serializers = BookSerializer(query,many=True)
        for book in serializers.data:
            fab_query = Favorite.objects.filter(
                user=request.user).filter(book_id=book['id'])
            if fab_query:
                book['Favorite'] = fab_query[0].isFavorit
            else:
                book['Favorite'] = False
            data.append(book)
        return Response(serializers.data)


       