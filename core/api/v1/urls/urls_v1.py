from django.urls import path
from core.api.v1.views.views import BookView

urlpatterns = [
    path('books/',BookView.as_view()),
]