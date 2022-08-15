from django.urls import path, include
from .views import *

app_name = "account"
urlpatterns = [
    path('', include('rest_framework.urls'))
]