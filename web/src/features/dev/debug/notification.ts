import { NotificationProps } from '../../../typings';
import { debugData } from '../../../utils/debugData';

export const debugCustomNotification = () => {
  debugData<NotificationProps>([
    {
      action: 'notify',
      data: {
        title: 'Success',
        description: 'Notification description',
        type: 'success',
        id: 'pogchamp',
        duration: 20000,
        style: {
          '.description': {
            color: 'red',
          },
        },
      },
    },
  ]);
  debugData<NotificationProps>([
    {
      action: 'notify',
      data: {
        title: 'Error',
        description: 'Notification description',
        type: 'error',
      },
    },
  ]);
  debugData<NotificationProps>([
    {
      action: 'notify',
      data: {
        title: 'Custom icon success',
        description: 'Notification description',
        type: 'success',
        icon: 'microchip',
<<<<<<< HEAD
=======
        showDuration: false,
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
      },
    },
  ]);
};
