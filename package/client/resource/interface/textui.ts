<<<<<<< HEAD
import { IconName, IconPrefix } from '@fortawesome/fontawesome-common-types';
import { CSSProperties } from 'react';
=======
import type { IconName, IconPrefix } from '@fortawesome/fontawesome-common-types';
import type { Properties as CSSProperties } from 'csstype';
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

type IconAnimation = 'spin' | 'spinPulse' | 'spinReverse' | 'pulse' | 'beat' | 'fade' | 'beatFade' | 'bounce' | 'shake';

interface OptionsProps {
<<<<<<< HEAD
  position?: 'right-center' | 'left-center' | 'top-center';
=======
  position?: 'right-center' | 'left-center' | 'top-center' | 'bottom-center';
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  icon?: IconName | [IconPrefix, IconName];
  iconColor?: string;
  iconAnimation?: IconAnimation;
  style?: CSSProperties;
  alignIcon?: 'top' | 'center';
}

export const showTextUI = (text: string, options?: OptionsProps): void => exports.ox_lib.showTextUI(text, options);

export const hideTextUI = (): void => exports.ox_lib.hideTextUI();

export const isTextUIOpen = (): boolean => exports.ox_lib.isTextUIOpen();
