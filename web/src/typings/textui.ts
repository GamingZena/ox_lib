import { IconProp } from '@fortawesome/fontawesome-svg-core';
import React from 'react';
import { IconAnimation } from '../components/LibIcon';

export type TextUiPosition = 'right-center' | 'left-center' | 'top-center' | 'bottom-center';

export interface TextUiProps {
  text: string;
  position?: TextUiPosition;
  icon?: IconProp;
  iconColor?: string;
  iconAnimation?: IconAnimation;
  style?: React.CSSProperties;
  alignIcon?: 'top' | 'center';
<<<<<<< HEAD
  keybind: string;
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
}
