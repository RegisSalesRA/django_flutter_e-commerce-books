from core.api.v1.serializers.serializers import *
from core.models import *
from rest_framework.views import APIView
from rest_framework import generics, filters, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


class BookView(APIView):
    search_fields = ['title']
    filter_backends = (filters.SearchFilter,)
    queryset = Book.objects.all()
    serializer_class = BookSerializer
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


class BookFilter(generics.ListCreateAPIView):
 #   permission_classes = [IsAuthenticated]
  #  authentication_classes = [TokenAuthentication,]    
    search_fields = ['title']
    filter_backends = (filters.SearchFilter,)
    queryset = Book.objects.all()
    serializer_class = BookSerializer


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




class CartView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        try:
            cart_obj = Cart.objects.filter(user=user).filter(isComplit=False)
            data = []
            cart_serializer = CartSerializers(cart_obj, many=True)
            for cart in cart_serializer.data:
                cart_book_obj = CartBook.objects.filter(cart=cart["id"])
                cart_book_obj_serializer = CartBookSerializers(
                    cart_book_obj, many=True)
                cart['cartbooks'] = cart_book_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg)


class OrderView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        try:
            query = Order.objects.filter(cart__user=request.user)
            serializers = OrdersSerializers(query, many=True)
            response_msg = {"error": False, "data": serializers.data}
        except:
            response_msg = {"error": True, "data": "no data"}
        return Response(response_msg)


class AddToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(sefl, request):
        book_id = request.data['id']
        book_obj = Book.objects.get(id=book_id)
        # print(book_obj, "book_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isComplit=False).first()
        cart_book_obj = CartBook.objects.filter(
            book__id=book_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_book_in_cart = cart_cart.cartbook_set.filter(
                    book=book_obj)
                if this_book_in_cart.exists():
                    cartprod_uct = CartBook.objects.filter(
                        book=book_obj).filter(cart__isComplit=False).first()
                    cartprod_uct.quantity += 1
                    cartprod_uct.subtotal += book_obj.selling_price
                    cartprod_uct.save()
                    cart_cart.total += book_obj.selling_price
                    cart_cart.save()
                else:
                    print("NEW CART book CREATED--OLD CART")
                    cart_book_new = CartBook.objects.create(
                        cart=cart_cart,
                        price=book_obj.selling_price,
                        quantity=1,
                        subtotal=book_obj.selling_price
                    )
                    cart_book_new.book.add(book_obj)
                    cart_cart.total += book_obj.selling_price
                    cart_cart.save()
            else:
                Cart.objects.create(user=request.user,
                                    total=0, isComplit=False)
                new_cart = Cart.objects.filter(
                    user=request.user).filter(isComplit=False).first()
                cart_book_new = CartBook.objects.create(
                    cart=new_cart,
                    price=book_obj.selling_price,
                    quantity=1,
                    subtotal=book_obj.selling_price
                )
                cart_book_new.book.add(book_obj)
                new_cart.total += book_obj.selling_price
                new_cart.save()
            response_mesage = {
                'error': False, 'message': "book add to card successfully", "bookid": book_id}
        except:
            response_mesage = {'error': True,
                               'message': "book Not add!Somthing is Wromg"}
        return Response(response_mesage)


class DelateCarBook(APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        cart_book_id = request.data['id']
        try:
            cart_book_obj = CartBook.objects.get(id=cart_book_id)
            cart_cart = Cart.objects.filter(
                user=request.user).filter(isComplit=False).first()
            cart_cart.total -= cart_book_obj.subtotal
            cart_book_obj.delete()
            cart_cart.save()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class DelateCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.delete()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class OrderCreate(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            data = request.data
            cart_id = data['cartid']
            address = data['address']
            email = data['email']
            phone = data['phone']
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.isComplit = True
            cart_obj.save()
            Order.objects.create(
                cart=cart_obj,
                email=email,
                address=address,
                phone=phone,
            )
            response_msg = {"error": False, "message": "Your Order is Complit"}
        except:
            response_msg = {"error": True, "message": "Somthing is Wrong !"}
        return Response(response_msg)
