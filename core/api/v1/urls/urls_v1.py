from django.urls import path
from core.api.v1.views.views import BookView,FavoriteView

urlpatterns = [
    path('books/',BookView.as_view()),
    path('favorite/',FavoriteView.as_view()),
]