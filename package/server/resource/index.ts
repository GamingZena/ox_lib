<<<<<<< HEAD
=======
import type { VehicleProperties } from 'shared';

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
export * from './acl';
export * from './locale';
export * from './callback';
export * from './version';
<<<<<<< HEAD
=======
export * from './addCommand';

export function setVehicleProperties(vehicle: number, props: VehicleProperties) {
  Entity(vehicle).state.set('ox_lib:setVehicleProperties', props, true)
}
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
