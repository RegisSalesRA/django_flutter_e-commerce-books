from django.urls import path
from core.api.v1.views.views import *
from rest_framework.authtoken.views import obtain_auth_token
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions



schema_view = get_schema_view(
   openapi.Info(
      title="Snippets API",
      default_version='v1',
      description="Test description",
      terms_of_service="https://www.google.com/policies/terms/",
      contact=openapi.Contact(email="contact@snippets.local"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path('books/',BookView.as_view()),
    path('books-filter/',BookFilter.as_view()),
    path('favorites/',FavoriteView.as_view()),
    path('logins/', obtain_auth_token),
    path('registers/', RegisterView.as_view()),
    path('order/', OrderView.as_view()),
    path('cart/',CartView.as_view()),
    path('addtocart/', AddToCart.as_view()),
    path('delatecartbooks/', DelateCarBook.as_view()),
    path('deletecart/', DelateCart.as_view()),
    path('ordernow/', OrderCreate.as_view()),
    path('swagger_v1', schema_view.with_ui('swagger',
                                 cache_timeout=0), name='schema-swagger-ui'),
    path("redoc", schema_view.with_ui('redoc',
                                      cache_timeout=0), name='schema-redoc'),
]