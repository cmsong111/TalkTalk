from django.urls import path, include
from django.contrib.auth.models import User
from rest_framework import routers, serializers, viewsets
from rest_auth.registration.serializers import RegisterSerializer

from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'username', 'nickname']


class CustomRegisterSerializer(RegisterSerializer):
    # 기본 설정 필드: username, password, email

    email = serializers.CharField(max_length=200)
    username = serializers.DateField()
    nickname = serializers.CharField(max_length=20)