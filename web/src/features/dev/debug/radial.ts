import { debugData } from '../../../utils/debugData';
<<<<<<< HEAD
import type { MenuItem } from '../../../typings';

export const debugRadial = () => {
  debugData<{ items: MenuItem[]; sub?: boolean }>([
=======
import type { RadialMenuItem } from '../../../typings';

export const debugRadial = () => {
  debugData<{ items: RadialMenuItem[]; sub?: boolean }>([
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    {
      action: 'openRadialMenu',
      data: {
        items: [
          { icon: 'palette', label: 'Paint' },
<<<<<<< HEAD
          { icon: 'warehouse', label: 'Garage' },
          { icon: 'palette', label: 'Quite long  \ntext' },
          { icon: 'palette', label: 'Paint' },
          { icon: 'warehouse', label: 'Garage' },
=======
          { iconWidth: 35, iconHeight: 35, icon: 'https://icon-library.com/images/white-icon-png/white-icon-png-18.jpg', label: 'External icon'},
          { icon: 'warehouse', label: 'Garage' },
          { icon: 'palette', label: 'Quite Long Text' },
          { icon: 'palette', label: 'Fahrzeuginteraktionen' },
          { icon: 'palette', label: 'Fahrzeuginteraktionen' },
          { icon: 'palette', label: 'Paint' },
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        ],
      },
    },
  ]);
};
