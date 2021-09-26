from django.contrib import admin
from django.urls import path

from friend.views import Friends_View,Delete_Friend

urlpatterns = [
    path('admin/', admin.site.urls),
    path('friends/', Friends_View.as_view(), name='friends'),
    path('delete/<int:pk>/', Delete_Friend.as_view(), name='deleteFriend'),
]