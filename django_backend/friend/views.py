from .models import Friend
from rest_framework import serializers, generics, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response


class FriendSerializer(serializers.HyperlinkedModelSerializer):
    """Serializer for Friends model"""

    class Meta:
        model = Friend
        fields = ['id', 'first_name', 'last_name', 'email', 'job']


class Friends_View(generics.ListCreateAPIView):
    """ Crate Friend & List all Friends"""
    queryset = Friend.objects.all()
    serializer_class = FriendSerializer
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            self.perform_create(serializer)
            return Response(status=status.HTTP_201_CREATED)


# https://www.cdrf.co/3.3/rest_framework.generics/DestroyAPIView.html cool
class Delete_Friend(generics.DestroyAPIView):
    queryset = Friend.objects.all()

    def destroy(self, request, pk=None, *args, **kwargs):
        friend = self.get_object()
        self.perform_destroy(friend)
        return Response("Friend successfully deleted", status=status.HTTP_200_OK)
