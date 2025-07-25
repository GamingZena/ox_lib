<<<<<<< HEAD
interface VehicleProperties {
  model: string;
  plate: string;
  plateIndex: number;
  bodyHealth: number;
  engineHealth: number;
  tankHealth: number;
  fuelLevel: number;
  oilLevel: number;
  dirtLevel: number;
  paintType1: number;
  paintType2: number;
  color1: number | [number, number, number];
  color2: number | [number, number, number];
  pearlescentColor: number;
  interiorColor: number;
  dashboardColor: number;
  wheelColor: number;
  wheelWidth: number;
  wheelSize: number;
  wheels: number;
  windowTint: number;
  xenonColor: number;
  neonEnabled: boolean[];
  neonColor: [number, number, number];
  extras: Record<number | string, 0 | 1>;
  tyreSmokeColor: [number, number, number];
  modSpoilers: number;
  modFrontBumper: number;
  modRearBumper: number;
  modSideSkirt: number;
  modExhaust: number;
  modFrame: number;
  modGrille: number;
  modHood: number;
  modFender: number;
  modRightFender: number;
  modRoof: number;
  modEngine: number;
  modBrakes: number;
  modTransmission: number;
  modHorns: number;
  modSuspension: number;
  modArmor: number;
  modNitrous: number;
  modTurbo: boolean;
  modSubwoofer: boolean;
  modSmokeEnabled: boolean;
  modHydraulics: boolean;
  modXenon: boolean;
  modFrontWheels: number;
  modBackWheels: number;
  modCustomTiresF: boolean;
  modCustomTiresR: boolean;
  modPlateHolder: number;
  modVanityPlate: number;
  modTrimA: number;
  modOrnaments: number;
  modDashboard: number;
  modDial: number;
  modDoorSpeaker: number;
  modSeats: number;
  modSteeringWheel: number;
  modShifterLeavers: number;
  modAPlate: number;
  modSpeakers: number;
  modTrunk: number;
  modHydrolic: number;
  modEngineBlock: number;
  modAirFilter: number;
  modStruts: number;
  modArchCover: number;
  modAerials: number;
  modTrimB: number;
  modTank: number;
  modWindows: number;
  modDoorR: number;
  modLivery: number;
  modRoofLivery: number;
  modLightbar: number;
  windows: number[];
  doors: number[];
  tyres: Record<number | string, 1 | 2>
  leftHeadlight: boolean;
  rightHeadlight: boolean;
  frontBumper: boolean;
  rearBumper: boolean;
  bulletProofTyres: boolean;
  driftTyres: boolean;
}
=======
import type { VehicleProperties } from '../../'
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

export const getVehicleProperties = (vehicle: number): VehicleProperties =>
  exports.ox_lib.getVehicleProperties(vehicle);

export const setVehicleProperties = (vehicle: number, props: Partial<VehicleProperties>, fixVehicle?: boolean): boolean =>
<<<<<<< HEAD
  exports.ox_lib.setVehicleProperties(vehicle, props);
=======
  exports.ox_lib.setVehicleProperties(vehicle, props, fixVehicle);
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
