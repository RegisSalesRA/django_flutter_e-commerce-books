from django.urls import path,include

urlpatterns = [
    path('v1/', include('core.api.v1.urls.urls_v1') ),
]