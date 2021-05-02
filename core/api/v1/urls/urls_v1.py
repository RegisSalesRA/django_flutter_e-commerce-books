from django.urls import path
from core.api.v1.views.views import BookView,FavoriteView,RegisterView
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('books/',BookView.as_view()),
    path('favorite/',FavoriteView.as_view()),
    path('login/', obtain_auth_token),
    path('register/', RegisterView.as_view())
]