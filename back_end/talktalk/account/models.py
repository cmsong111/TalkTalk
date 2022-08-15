from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin

class UserManager(BaseUserManager):    
   use_in_migrations = True  

   def create_user(self, email, password, username, nickname):        
       
       if not email:            
           raise ValueError('must have user email')
       if not password:            
           raise ValueError('must have user password')

       user = self.model(            
           email=self.normalize_email(email),
           username = username,
           nickname = nickname,
           password=password
       )        
       user.set_password(password)        
       user.save(using=self._db)        
       return user

   def create_superuser(self, email, password, username, nickname):        
   
       user = self.create_user(            
            email = self.normalize_email(email),
            username = username,
            nickname = nickname,
            password=password        
       )
       user.is_admin = True
       user.is_superuser = True
       user.save(using=self._db)
       return user

# Create your models here.
class User(AbstractBaseUser, PermissionsMixin):
    
    objects = UserManager()

    id = models.AutoField(primary_key=True)

    email = models.EmailField(max_length = 200, unique=True)
    username = models.CharField(max_length=100)
    nickname = models.CharField(max_length=100, unique=True)

    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)
    is_admin = models.BooleanField(default=False)


    USERNAME_FIELD = 'email'
    EMAIL_FIELD = 'email'
    REQUIRED_FIELDS = ['nickname','username']

    def __str__(self):
        return self.name

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True

    @property
    def is_staff(self):
        return self.is_admin