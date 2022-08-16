from django.urls import path, include
from .views import *
from rest_framework_simplejwt.views import(
    TokenObtainPairView,
    TokenRefreshView,
    
)


urlpatterns = [
    path('login/', TokenObtainPairView.as_view(), name= 'token_obtain_pair'),
    path('token/refresh/',TokenRefreshView.as_view(), name="token_refresh"),
]