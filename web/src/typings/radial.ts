import { IconProp } from '@fortawesome/fontawesome-svg-core';

export interface RadialMenuItem {
<<<<<<< HEAD
  icon: IconProp;
  label: string;
  isMore?: boolean;
  menu?: string;
=======
  icon: string | IconProp;
  label: string;
  isMore?: boolean;
  menu?: string;
  iconWidth?: number;
  iconHeight?: number;
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
}
