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


class FavoriteView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication,]

    def post(self, request):
        data = request.data["id"]
        # print(data)
        try:
            book_obj = Book.objects.get(id=data)
            # print(data)
            user = request.user
            single_favorite_book = Favorite.objects.filter(
                user=user).filter(book=book_obj).first()
            if single_favorite_book:
                print("single_favorite_book")
                ccc = single_favorite_book.isFavorit
                single_favorite_book.isFavorit = not ccc
                single_favorite_book.save()
            else:
                Favorite.objects.create(
                    book=book_obj, user=user, isFavorit=True)
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)

class RegisterView(APIView):
    def post(self,request):
        serializers = Userserializer(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({'error':False})
        return Response({'error':True})    