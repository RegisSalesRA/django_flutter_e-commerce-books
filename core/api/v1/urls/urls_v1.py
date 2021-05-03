from django.urls import path
from core.api.v1.views.views import BookView,FavoriteView,RegisterView
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('books/',BookView.as_view()),
    path('favorites/',FavoriteView.as_view()),
    path('logins/', obtain_auth_token),
    path('registers/', RegisterView.as_view()),
]