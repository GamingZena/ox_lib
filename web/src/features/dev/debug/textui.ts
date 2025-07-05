import { TextUiProps } from '../../../typings';
import { debugData } from '../../../utils/debugData';

export const debugTextUI = () => {
  debugData<TextUiProps>([
    {
      action: 'textUi',
      data: {
<<<<<<< HEAD
        text: 'Влез',
        position: 'right-center',
        icon: 'door-open',
        keybind: 'E',
=======
        text: '[E] - Access locker inventory  \n [G] - Do something else',
        position: 'right-center',
        icon: 'door-open',
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
      },
    },
  ]);
};
